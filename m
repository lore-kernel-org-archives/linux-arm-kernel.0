From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 20 Nov 2014 10:39:32 +0000
Subject: [PATCH v9 05/13] arm: introduce is_device_dma_coherent
In-Reply-To: <20141120000736.GN4042@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1411121130020.26318@kaball.uk.xensource.com>
 <1415792454-23161-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1411141158560.26318@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1411181649000.27247@kaball.uk.xensource.com>
 <20141120000736.GN4042@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1411201036400.12596@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Nov 2014, Russell King - ARM Linux wrote:
> On Tue, Nov 18, 2014 at 04:49:21PM +0000, Stefano Stabellini wrote:
> > ping?
> 
> Sending something which wants my attention _To:_ me is always a good idea :)

I'll keep that in mind :-)


> The patch is fine in itself, but I have a niggle about the
> is_device_dma_coherent() - provided this is only used in architecture
> specific code, that should be fine.  It could probably do with a comment
> to that effect in an attempt to discourage drivers using it (thereby
> becoming less portable to other architectures.)

Can I take this as an Acked-by?
Good point regarding the comment. Maybe I can add:

/* do not use this function in a driver */
