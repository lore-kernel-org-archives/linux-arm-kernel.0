From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 May 2012 12:41:42 +0800
Subject: [PATCH V2 0/1] dmaengine/amba-pl08x: Add support for s3c64xx DMAC
In-Reply-To: <CAGOxZ52w1nn8g4d_vuNAzjA9qYZ1=yEfihFvSOK+pBz=ZD=J7Q@mail.gmail.com>
References: <1317189007-23033-1-git-send-email-alim.akhtar@samsung.com>
 <CACRpkdZC8LOOLkWbrPbXN_nKaw-WvueusYDyrX48Q1Pcdwv3Aw@mail.gmail.com>
 <CAGOxZ52w1nn8g4d_vuNAzjA9qYZ1=yEfihFvSOK+pBz=ZD=J7Q@mail.gmail.com>
Message-ID: <CACRpkdZO=B9gWkhvgf4Ewi1GKibFxki36uF06ispQzDK7T+4sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 8, 2011 at 9:03 AM, Alim Akhtar <alim.akhtar@gmail.com> wrote:

> Hello Linus,
> sorry for the delay in submitting V3 of the pl080 patches for s3c64xx.
> I am very busy with my current assignment.
> I will come back to my patch series incorporating yours and Viresh
> suggestions in v3.

Ping on this, is there something in specific that you need help on here?
We really need to get rid of this forked code, and it should be beneficial
to S3C because we have fixed a lot of bugs in the PL08x driver now,
plus it'll likely be a prerequisite to DT support for S3C.

Yours,
Linus Walleij
