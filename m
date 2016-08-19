From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Aug 2016 08:42:55 -0500
Subject: [PATCH v3 1/3] devicetree: Sort vendor prefixes in alphabetical
 order
In-Reply-To: <54da74da3f60ede0bf8fb789ffee584703e81a29.1471553094.git.ccc94453@vip.cybercity.dk>
References: <54da74da3f60ede0bf8fb789ffee584703e81a29.1471553094.git.ccc94453@vip.cybercity.dk>
Message-ID: <20160819134255.GA29943@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 11:13:34PM +0200, Rask Ingemann Lambertsen wrote:
> Vendor prefixes should be listed in alphabetical order, which some of
> them weren't, so this patch corrects that.
> 
> Signed-off-by: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>
> ---
> 
> I used 'sort --ignore-case --key 1,1'.
> 
> Changes in v3:
> This patch is new in v3.
> 
>  .../devicetree/bindings/vendor-prefixes.txt        | 30 +++++++++++-----------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Oh, there's a lot more than I realized. I'd suggest that I take patches 
1 and 2 thru my tree so I can manage any conflicts.

Rob
