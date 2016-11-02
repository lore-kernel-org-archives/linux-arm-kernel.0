From: david@lechnology.com (David Lechner)
Date: Wed, 2 Nov 2016 16:44:06 -0500
Subject: [PATCH 3/3] usb: ohci-da8xx: rename driver to ohci-da8xx
In-Reply-To: <20161102124435.31777-4-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <20161102124435.31777-4-ahaslam@baylibre.com>
Message-ID: <ba761a43-6b44-94d1-8609-278075886518@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2016 07:44 AM, Axel Haslam wrote:
> To be consistent on the usb driver for the davinci
> platform follow the example of musb, and add the
> "-da8xx" postfix to the driver name.
>

It is probably worth mentioning that the existing driver name is "ohci" 
which is a bit too generic.
