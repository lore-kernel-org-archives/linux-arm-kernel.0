From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Aug 2018 08:56:53 -0600
Subject: [PATCH v4 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
In-Reply-To: <1533374735-16662-3-git-send-email-manish.narani@xilinx.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-3-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180807145652.GA4106@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 04, 2018 at 02:55:33PM +0530, Manish Narani wrote:
> This patch adds information of ZynqMP DDRC which reports the single bit
> errors that are corrected and the double bit errors that are detected.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
