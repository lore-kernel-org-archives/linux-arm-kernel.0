From: robh@kernel.org (Rob Herring)
Date: Tue, 4 Sep 2018 09:16:18 -0500
Subject: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
In-Reply-To: <1535722070-10394-3-git-send-email-manish.narani@xilinx.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-3-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180904141618.GA5516@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 06:57:48PM +0530, Manish Narani wrote:
> Add information of ZynqMP DDRC which reports the single bit errors that
> are corrected and the double bit errors that are detected.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Please add acks/reviewed-bys when posting new versions.

Rob
