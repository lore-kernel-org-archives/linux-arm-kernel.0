From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jul 2018 14:12:14 +0800
Subject: [PATCH v1] ARM: dts: imx51-zii-rdu1: correct touchscreen axis
 inversion
In-Reply-To: <20180628225626.26203-1-nick@shmanahar.org>
References: <20180628225626.26203-1-nick@shmanahar.org>
Message-ID: <20180703061212.GG4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 11:56:26PM +0100, Nick Dyer wrote:
> The RMI4 touchscreen driver applied inversion and axis swap in the
> wrong order, violating the DT binding for those properties. This was fixed in
> 645a397, so correct the RDU1 DT to apply the inversion to the
> correct axis.
> 
> Tested on Zii RDU1 00-5105-30 rev B
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

Applied, thanks.
