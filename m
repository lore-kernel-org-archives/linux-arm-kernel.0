From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 7 May 2015 00:14:01 -0700
Subject: [PATCH 1/3] mtd: mxc-nand: Constify platform_device_id
In-Reply-To: <1430495403-31560-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495403-31560-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150507071401.GI6055@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 02, 2015 at 12:50:01AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Pushed all 3 to l2-mtd.git.

Brian
