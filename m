From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 9 Jan 2013 16:41:50 +0200
Subject: [PATCH v2 04/11] ARM: Tegra: Define Tegra30 CAR binding
In-Reply-To: <1356619644-18565-5-git-send-email-pgaikwad@nvidia.com>
References: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
 <1356619644-18565-5-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130109144150.GS26066@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 03:47:17PM +0100, Prashant Gaikwad wrote:
> The device tree binding models Tegra30 CAR (Clock And Reset)
> as a single monolithic clock provider.
> 
...

> +  8	gpio

This clock isn't defined further on though...

Cheers,

Peter.
