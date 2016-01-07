From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Jan 2016 21:51:28 -0200
Subject: [PATCH V2] serial: imx: Fix suspend / resume.
In-Reply-To: <CAOMZO5BES=YkYjtjPE_=t9Qa11JsgE0TT8-v0CxmtgSuBwWnmw@mail.gmail.com>
References: <20160105155331.6024.7211.stgit@localhost>
 <CAOMZO5BES=YkYjtjPE_=t9Qa11JsgE0TT8-v0CxmtgSuBwWnmw@mail.gmail.com>
Message-ID: <CAOMZO5ADYomDf5EbGAAPJSjEQFOfKi_r7j+xytSuQA5dQh=V0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 9:17 PM, Fabio Estevam <festevam@gmail.com> wrote:

> [   39.487313] [<c05844d0>] (snd_soc_suspend) from [<c03c31f0>]

Ok, in this case it is an ALSA issue, so will start a thread at the
alsa mailing list.
