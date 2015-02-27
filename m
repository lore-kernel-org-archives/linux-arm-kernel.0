From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 27 Feb 2015 07:29:30 -0800
Subject: Bug in i2c-core?
In-Reply-To: <20150227153725.7404dea1@free-electrons.com>
References: <54F0507F.6030804@armadeus.com>
 <20150227153725.7404dea1@free-electrons.com>
Message-ID: <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On February 27, 2015 6:37:25 AM PST, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>Dear S?bastien SZYMANSKI,
>
>On Fri, 27 Feb 2015 12:09:51 +0100, S?bastien SZYMANSKI wrote:
>
>>         error = input_register_device(sx8654->input);
>>         if (error)
>>                 return error;
>
>Where is your ->remove() function that unregisters the input device?

Everything seems to be allocated with devm so remove is not needed.


Thanks.

-- 
Dmitry
