From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 25 Jun 2015 09:27:11 +0200
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <20150625072205.GO4156@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel> <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel> <20150506114417.GI30910@pali>
 <20150625050138.GL4156@atomide.com> <20150625071851.GB2890@pali>
 <20150625072205.GO4156@atomide.com>
Message-ID: <20150625072711.GD2890@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 June 2015 00:22:05 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [150625 00:21]:
> > 
> > Ok, but what do you mean to forget any string conversion?
> 
> No need for tohexstr() in the uncommpress code if the system_rev
> value is a number coming from the dts.
> 
> Regards,
> 
> Tony

So /revision DT property will be (binary) value, right?

-- 
Pali Roh?r
pali.rohar at gmail.com
