From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 20 Mar 2014 16:54:23 +0100
Subject: [RFC PATCH] staging: imx-drm: add suspend / resume
In-Reply-To: <CAOMZO5CN9gwxK42gctkEarT+jiqAOmVCKJ=X30cXtg5dS0Fumg@mail.gmail.com>
References: <20140320151712.22089.59230.stgit@localhost>
 <CAOMZO5CN9gwxK42gctkEarT+jiqAOmVCKJ=X30cXtg5dS0Fumg@mail.gmail.com>
Message-ID: <532B0F2F.7040206@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,
On 20/03/14 16:31, Fabio Estevam wrote:
> Does this patch still cause the visual artifacts you mentioned 
> earlier? Regards, Fabio Estevam 

No.

Since I switched from poking the registers to using the existing 
wrappers I have not observed any artifcats.

Regards,

Martin
