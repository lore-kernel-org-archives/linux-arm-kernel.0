From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Feb 2013 14:26:11 -0200
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <201302100428.54061.marex@denx.de>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130208164858.GA32318@mudshark.cambridge.arm.com>
 <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
 <201302100428.54061.marex@denx.de>
Message-ID: <CAOMZO5B2yQv+HBnq8C1RE+LD1Lj-DGa3-iJ=yjG5xKKpNK4x7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 1:28 AM, Marek Vasut <marex@denx.de> wrote:

> Is the amba-pl011 driver maybe broken ?

At least on mx28evk, ttyAMA0 is not getting registered when running linux-next.

I haven't had a chance to debug it though.
