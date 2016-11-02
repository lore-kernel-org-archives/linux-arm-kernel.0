From: david@lechnology.com (David Lechner)
Date: Wed, 2 Nov 2016 16:41:46 -0500
Subject: [PATCH 2/3] phy: da8xx-usb: rename the ohci device to ohci-da8xx
In-Reply-To: <20161102124435.31777-3-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <20161102124435.31777-3-ahaslam@baylibre.com>
Message-ID: <dc1c5a39-8e89-81b3-d0ae-1da91ac6c758@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2016 07:44 AM, Axel Haslam wrote:
> There is only one ohci on the da8xx series of chips,
> so remove the ".0" when creating the phy. Also add
> the "-da8xx" postfix to be consistent across davinci
> usb drivers.

It would be more accurate to say that the device name is being changed 
in the mach board configuration files, so it is being changed here in 
the lookup table to match the new name.

>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
