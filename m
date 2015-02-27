From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Feb 2015 15:37:25 +0100
Subject: Bug in i2c-core?
In-Reply-To: <54F0507F.6030804@armadeus.com>
References: <54F0507F.6030804@armadeus.com>
Message-ID: <20150227153725.7404dea1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear S?bastien SZYMANSKI,

On Fri, 27 Feb 2015 12:09:51 +0100, S?bastien SZYMANSKI wrote:

>         error = input_register_device(sx8654->input);
>         if (error)
>                 return error;

Where is your ->remove() function that unregisters the input device?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
