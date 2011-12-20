From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 21:19:08 +0000
Subject: [PATCH 7/8] s3c-hsudc: use release_mem_region instead of
 release_resource
In-Reply-To: <20111220210947.GA7352@legolas.emea.dhcp.ti.com>
References: <201112191938.22254.heiko@sntech.de>
 <201112191942.52629.heiko@sntech.de>
 <20111220201049.GB2577@n2100.arm.linux.org.uk>
 <20111220210947.GA7352@legolas.emea.dhcp.ti.com>
Message-ID: <20111220211908.GG2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 11:09:48PM +0200, Felipe Balbi wrote:
> On Tue, Dec 20, 2011 at 08:10:49PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 19, 2011 at 07:42:52PM +0100, Heiko St?bner wrote:
> > > As the memory region is requested through request_mem_region
> > > use the correct paired method to release it in the error path
> > > and don't go "beneath the API" as pointed out by Russel King.
> > 
> > Please correct the spelling, thanks.
> 
> Just did, do you prefer that I add a Reported-by: Russell instead of
> that mention ?

If you wish - I don't mind.  If you do, please use an email address
of rmk+kernel at arm.linux.org.uk in the attributations.  Thanks.
