From: geoff@infradead.org (Geoff Levand)
Date: Wed, 20 Jan 2016 13:15:49 -0800
Subject: [PATCH 00/19] arm64 kexec kernel patches v13
In-Reply-To: <20160120025621.GC2999@dhcp-128-65.nay.redhat.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <20160119123230.GB2904@dhcp-128-65.nay.redhat.com>
 <1453248900.21755.8.camel@infradead.org>
 <20160120025621.GC2999@dhcp-128-65.nay.redhat.com>
Message-ID: <1453324549.21755.10.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-20 at 10:56 +0800, Dave Young wrote:
> On 01/19/16 at 04:15pm, Geoff Levand wrote:
> > On Tue, 2016-01-19 at 20:32 +0800, Dave Young wrote:
> > > Geoff, another question about kexec-tools part is, can the kexec
> > > -tools code
> > > been written in kernel? We have the infrastructure for
> > > kexec_file_load.
> > 
> > I see no technical reason why the arm64 kernel cannot support
> > kexec_file_load.
> 
> Cool, care to port it to kernel so that we have kexec_file_load only
> in arm64
> we do not need to support both kexec_load and kexec_file_load?
> 

I have no plans to do so.  Feel free to submit a patch.

-Geoff
