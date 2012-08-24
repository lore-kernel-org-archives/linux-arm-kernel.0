From: sbkim73@samsung.com (Sangbeom Kim)
Date: Fri, 24 Aug 2012 19:06:52 +0900
Subject: [alsa-devel] [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
In-Reply-To: <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
 <00df01cd81cb$e21d2f00$a6578d00$@com>
 <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
Message-ID: <00f001cd81e0$2ed8ccf0$8c8a66d0$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2012 at 4:52 PM, Dylan Reid wrote:
> Yes. Currently, if I suspend while playing, after resume it won't work
> until I close and reopen the device.  the call to snd_pcm_resume is
> not indicating an error, but a write error comes from snd_pcm_write a
> little later.

Ok, 
Please let me know your test environment.

Thanks,
Sangbeom.
