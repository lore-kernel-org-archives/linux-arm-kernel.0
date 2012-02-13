From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Feb 2012 20:43:50 +0100
Subject: [PATCH][V3] ux500 : decouple/recouple gic from the PRCMU
In-Reply-To: <4F34F39E.2080109@linaro.org>
References: <1328869344-31332-1-git-send-email-daniel.lezcano@linaro.org>
 <4F34F39E.2080109@linaro.org>
Message-ID: <CACRpkdYeTxU8qGJ7F2jWSfL3Mgd4xo2re6D=HfPgVxmEumtC_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 11:38 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> I think I addressed all the concerns, is it possible to merge this patch ?

As detailed in another letter: does this build on top of the patch series
"DB8500 PRCMU update" that was submitted some time ago? Please
make sure it is either that or orthogonal so they don't collide.

Second: it's not me merging patches to the MFD subsystem, it's the
MFD subsystem maintainer Saumel Ortiz.

Yours,
Linus Walleij
