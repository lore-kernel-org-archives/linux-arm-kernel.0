From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 27 Mar 2014 13:31:00 -0300
Subject: [PATCH 1/1] ARM: imx: Add DTSC02 platform (i.MX27)
In-Reply-To: <533449F9.4090101@gmail.com>
References: <1395934153-19416-1-git-send-email-gcembed@gmail.com>
 <CAOMZO5AwfrXVoZfCKFQHBTDcUm4cfAVVX6fJabY0_S0gtbX_eQ@mail.gmail.com>
 <53344680.6080800@gmail.com> <533449F9.4090101@gmail.com>
Message-ID: <CAOMZO5Bjo4+AuFrU5tWukNbnLcWLApA+vCfphfKOCJRJrLaZ8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 12:55 PM, Ga?tan Carlier <gcembed@gmail.com> wrote:

> I am using Redboot (ecos 20090512), I supposed that is not directly
> compatible and I have to append DTS blob to zImage as specified in slides
> petazzoni-device-tree-dummies.pdf ?

Yes, correct. This method works fine.
