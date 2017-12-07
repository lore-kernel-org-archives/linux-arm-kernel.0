From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 7 Dec 2017 14:30:52 +0000
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <20171205104538.b4fxdjad3c46koas@phenom.ffwll.local>
References: <20171130030907.26848-1-seanpaul@chromium.org>
 <20171130030907.26848-2-seanpaul@chromium.org>
 <20171205102840.GB12982@amd>
 <20171205104538.b4fxdjad3c46koas@phenom.ffwll.local>
Message-ID: <20171207143052.533e1e94@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If you want to actually lock down a machine to implement content
> protection, then you need secure boot without unlockable boot-loader and a
> pile more bits in userspace. 

So let me take my Intel hat off for a moment.

The upstream policy has always been that we don't merge things which
don't have an open usable user space. Is the HDCP encryption feature
useful on its own ? What do users get from it ?

If this is just an enabler for a lump of binary stuff in ChromeOS then I
don't think it belongs, if it is useful standalone then it seems it does
belong ?

Alan
