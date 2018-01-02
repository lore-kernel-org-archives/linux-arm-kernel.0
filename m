From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jan 2018 13:13:29 -0200
Subject: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for i.mx6ul
In-Reply-To: <A2F3BA8B-361A-4809-83FE-4067CD868D5B@nxp.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Do-tyR0ruqfSeJm2FDP7_chNeroFStTF85GnSt_2g5Uw@mail.gmail.com>
 <A2F3BA8B-361A-4809-83FE-4067CD868D5B@nxp.com>
Message-ID: <CAOMZO5DvKi4nXfoSBWbe6qedoWO7RiSP5CvJEkBAVUioyVBN=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Tue, Jan 2, 2018 at 1:05 PM, Anson Huang <anson.huang@nxp.com> wrote:

> This change is to support 696MHz operating point, both the speed grading
> check and pll rate change are necessary for 696MHz support, do you think
> they should be in different patch?

I thought  this could also change the behaviour for mx6q/dl/qp.

Are the others SoCs safe with this change?
