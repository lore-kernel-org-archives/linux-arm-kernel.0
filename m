From: dgreid@chromium.org (Dylan Reid)
Date: Fri, 24 Aug 2012 10:29:01 -0700
Subject: [alsa-devel] [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
In-Reply-To: <00f001cd81e0$2ed8ccf0$8c8a66d0$@com>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
 <00df01cd81cb$e21d2f00$a6578d00$@com>
 <CAEUnVG58NPNKuf_PRyBEegYnH95dkTN81PGZGYxDt41jhH2uaQ@mail.gmail.com>
 <00f001cd81e0$2ed8ccf0$8c8a66d0$@com>
Message-ID: <CAEUnVG5WKsxML8L-ZUo_sNupjZYa11qFY4fPOX2SpUzLPFLWkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 3:06 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> On Thu, Aug 24, 2012 at 4:52 PM, Dylan Reid wrote:
>> Yes. Currently, if I suspend while playing, after resume it won't work
>> until I close and reopen the device.  the call to snd_pcm_resume is
>> not indicating an error, but a write error comes from snd_pcm_write a
>> little later.
>
> Ok,
> Please let me know your test environment.

I'm using a 5250 evaluation board with a max98095 codec.

>
> Thanks,
> Sangbeom.
>
