From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 16 Nov 2014 09:11:04 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141116075928.GA9763@amd>
References: <20141116075928.GA9763@amd>
Message-ID: <54685C18.1020109@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2014 08:59 AM, Pavel Machek wrote:
>[...]
> +	adp1653: adp1653 at 30 {
> +		compatible = "ad,adp1653";

The Analog Devices vendor prefix is adi.
