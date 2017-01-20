From: tj@kernel.org (Tejun Heo)
Date: Fri, 20 Jan 2017 10:00:36 -0500
Subject: [PATCH v5 00/14] ARM: da850-lcdk: add SATA support
In-Reply-To: <f9055043-507f-74de-b2b8-9eb0eae5dad6@ti.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
 <20170120132843.GA31487@mtj.duckdns.org>
 <86bcbb3c-87e4-3508-f4a6-26529f39d374@ti.com>
 <CAMpxmJUPh9MZKwG6k6p_mo6niXNNT02JCDgXi4DPRH2Fk3yxng@mail.gmail.com>
 <f9055043-507f-74de-b2b8-9eb0eae5dad6@ti.com>
Message-ID: <20170120150036.GA6164@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Sekhar.

On Fri, Jan 20, 2017 at 07:52:35PM +0530, Sekhar Nori wrote:
> Tejun, I am open to queuing the driver changes through ARM-SoC. I guess
> with that there is little chance that SATA will be broken on linux-next
> for a longish period of time.

Yeah, I'd prefer the patchset staying together.  That's how it was
developed and tested.  Don't wanna break it apart unnecessarily.  The
chance for conflicts is low and even when that happens dealing with
them is pretty easy.  Please feel free to add my acked-by and route
the patches through ARM-SoC.

Thanks.

-- 
tejun
