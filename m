From: p.pisati@gmail.com (Paolo Pisati)
Date: Mon, 25 Mar 2013 11:30:04 +0100
Subject: [PATCH] ARM: l2x0: don't set .set_debug in l310 case
In-Reply-To: <514F6CD1.5010409@gmail.com>
References: <1364149654-16163-1-git-send-email-p.pisati@gmail.com>
 <514F6CD1.5010409@gmail.com>
Message-ID: <20130325103004.GB3330@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 24, 2013 at 04:14:57PM -0500, Rob Herring wrote:
> On 03/24/2013 01:27 PM, Paolo Pisati wrote:
> > From: Paolo Pisati <paolo.pisati@canonical.com>
> > 
> > commit 74ddcdb ("l2x0: Only set .set_debug on PL310 r3p0 and earlier")
> > to actually work needs .set_debug to be not set during definition
> > 
> > Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> 
> Ah crap, missed this part. Can I add this into my fix and I'll put it in
> Russell's patch system.

Of course, go ahead.
-- 
bye,
p.
