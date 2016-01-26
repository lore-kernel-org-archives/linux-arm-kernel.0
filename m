From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 26 Jan 2016 15:39:49 +0100 (CET)
Subject: [PATCH 12/13] atmel-isi: use union for the fbd (frame buffer
 descriptor)
In-Reply-To: <CAJe_HAdtFCmYKeCgfs9FeE80ckH3+WRfejmc_WOxdxZEntgL8A@mail.gmail.com>
References: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
 <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
 <1453121545-27528-8-git-send-email-rainyfeeling@gmail.com>
 <Pine.LNX.4.64.1601241931430.16570@axis700.grange>
 <CAJe_HAeTWqaqFHPbLGzbTKV6s2xDxf+Dg8DFc6HAqs03RJFh3g@mail.gmail.com>
 <Pine.LNX.4.64.1601261509120.28816@axis700.grange>
 <CAJe_HAdtFCmYKeCgfs9FeE80ckH3+WRfejmc_WOxdxZEntgL8A@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1601261538550.28816@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jan 2016, Josh Wu wrote:

> Ok, so for this serial patch, I will drop the abstract interface
> relevant patches, and keep the refactor patch in v2. Thanks.

Yes, please, drop the last 2 patches, and, preferably, the "polling 
instead of IRQ" one too.

Thanks
Guennadi
