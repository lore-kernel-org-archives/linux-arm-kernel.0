From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 Jun 2015 00:41:30 -0700
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <20150625072711.GD2890@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel> <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel> <20150506114417.GI30910@pali>
 <20150625050138.GL4156@atomide.com> <20150625071851.GB2890@pali>
 <20150625072205.GO4156@atomide.com> <20150625072711.GD2890@pali>
Message-ID: <20150625074130.GP4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150625 00:29]:
> On Thursday 25 June 2015 00:22:05 Tony Lindgren wrote:
> > * Pali Roh?r <pali.rohar@gmail.com> [150625 00:21]:
> > > 
> > > Ok, but what do you mean to forget any string conversion?
> > 
> > No need for tohexstr() in the uncommpress code if the system_rev
> > value is a number coming from the dts.
> 
> So /revision DT property will be (binary) value, right?

Right just u32 value.

Regards,

Tony
