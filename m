From: leigh@solinno.co.uk (Leigh Brown)
Date: Thu, 19 Dec 2013 12:39:22 +0000
Subject: [PATCH] net: mvmdio: fix interrupt timeout handling
In-Reply-To: <52B2D97F.4070200@gmail.com>
References: <1387451589-15491-1-git-send-email-leigh@solinno.co.uk>
 <52B2D97F.4070200@gmail.com>
Message-ID: <a1205db8e38fbdc0cf64f235de54cc67@doppler.thel33t.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-19 11:33, Sebastian Hesselbarth wrote:
>> +			 if (timeout < 2)
>> +			 	timeout = 2;
> 
> Hi Leigh,
> 
> above two lines have a whitespace issue.

Crap, you are correct.  I will fix it and send another patch.

Regards,

Leigh.
