From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 May 2014 00:24:58 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: split SolidRun CuBox into variants
In-Reply-To: <538508A5.2010809@gmail.com>
References: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140527213549.GU8664@titan.lakedaemon.net> <538508A5.2010809@gmail.com>
Message-ID: <32589428.8iAxtgFCnl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 27. Mai 2014, 23:50:29 schrieb Sebastian Hesselbarth:
> On 05/27/2014 11:35 PM, Jason Cooper wrote:
> > On Tue, May 27, 2014 at 07:28:09PM +0200, Sebastian Hesselbarth wrote:
> >> On 05/27/2014 06:11 PM, Jason Cooper wrote:
> >>> On Mon, May 26, 2014 at 11:33:29PM +0200, Sebastian Hesselbarth wrote:
> > info.  It may be useful here, but I'd like to hear from the DT
> > maintainers how they want it used.  eg: most popular first, like you
> > have it, or oldest first
> > 
> > dove-cubox-es.dts
> > +--> dove-cubox.dts
> 
> In the cubox case, this is not possible. ES has a misrouted
> card-detection for sdhci, this requires an additional property.
> There is no way to remove a property once it is written down in
> any of the files included. But you know about that already.

dtc knows "/delete-property/" [0], but I may be missing something here.


[0] https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-August/018169.html
