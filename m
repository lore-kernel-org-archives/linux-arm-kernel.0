From: dianders@chromium.org (Doug Anderson)
Date: Thu, 28 Feb 2013 16:55:36 -0800
Subject: [PATCH v3 0/2] Add automatic bus number support for i2c busses
 with device tree
In-Reply-To: <20130228232558.GA8180@the-dreams.de>
References: <1360630085-26874-1-git-send-email-dianders@chromium.org>
 <CAD=FV=WS5Vj74d-FNXCVpNsx6Nf-8+RC-WO29Z1XNmkEOYLxfQ@mail.gmail.com>
 <20130228232558.GA8180@the-dreams.de>
Message-ID: <CAD=FV=XnhG_gM7mFLRHKt=j3a249QsbbgDb4cTCGa7297svVeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

On Thu, Feb 28, 2013 at 3:25 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> Regarding patch 1, I was waiting for the idr changes to hit mainline.
> They are mainline now, but since the removal of MAX_IDR_MASK your patch
> doesn't apply anymore :( Can you rebase and retest, please? I'd like to
> get it into 3.9, still.

Yes, I'll rebase/retest tomorrow.  I'll let you make the call between
3.9 and 3.10.  Obviously I'd love to see it in 3.9 but I'm OK with
either.  I was just hoping not to find out at the end of the 3.10
cycle that it needs fixes and need to wait for 3.11.  I wanted to make
sure all my ducks were in a row.  ;-)


> For patch 2, some Tested-by would be nice; but it will probably make it
> into my for-next somewhen after rc1 is out.

I have no urgent need for patch 2 to land but it seemed nice to tidy
up the pxa driver and I felt it was my obligation to post it together
with patch set #1 (plus it's always nice to remove code).  Putting it
into your for-next seems like a very good solution.  That gives people
some time to test it and make sure it works for them.


Thanks!

-Doug
