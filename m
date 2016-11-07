From: horms@verge.net.au (Simon Horman)
Date: Mon, 7 Nov 2016 13:40:45 +0100
Subject: [PATCH v2] ARM: DTS: r8a7794: alt: Fix PFC names for DU
In-Reply-To: <c0a3c44b-545c-7af3-feed-857cb20ef698@cogentembedded.com>
References: <1478180574-15464-1-git-send-email-jacopo@jmondi.org>
 <1478201686-25488-1-git-send-email-jacopo@jmondi.org>
 <c0a3c44b-545c-7af3-feed-857cb20ef698@cogentembedded.com>
Message-ID: <20161107124044.GE12319@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 02:43:18PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/3/2016 10:34 PM, Jacopo Mondi wrote:
> 
> >Update the PFC pin groups and function names of DU interface for
> >r8a7794 ALT board.
> >
> >The currently specified pin groups and function names prevented PFC and
> >DU interfaces from being correctly configured:
> >
> >sh-pfc e6060000.pin-controller: function 'du' not supported
> >sh-pfc e6060000.pin-controller: invalid function du in map table
> >sh-pfc e6060000.pin-controller: function 'du' not supported
> >sh-pfc e6060000.pin-controller: invalid function du in map table
> >sh-pfc e6060000.pin-controller: function 'du' not supported
> >sh-pfc e6060000.pin-controller: invalid function du in map table
> >sh-pfc e6060000.pin-controller: function 'du' not supported
> >sh-pfc e6060000.pin-controller: invalid function du in map table
> >rcar-du: probe of feb00000.display failed with error -22
> >
> >Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up.
