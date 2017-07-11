From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 11 Jul 2017 10:05:47 +0800
Subject: [PATCH v4 1/3] ARM: dts: imx6ul-isiot: Move common nodes in
 imx6ul-isiot.dtsi
In-Reply-To: <1497528219-20396-1-git-send-email-jteki@openedev.com>
References: <1497528219-20396-1-git-send-email-jteki@openedev.com>
Message-ID: <20170711020545.GB3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 05:33:37PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Maintaining separate dtsi file with common nodes make unclear and
> confusing since -isiot.dtsi is available for adding common nodes.
> If the nodes are common between the dts files then mark status
> as "okay" otherwise mark it "disabled" so-that respective dts
> can mark status "okay"
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied all, thanks.
