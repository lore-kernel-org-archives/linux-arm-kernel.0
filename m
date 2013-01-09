From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 9 Jan 2013 17:42:00 +0200
Subject: [PATCH 04/11] ARM: Tegra: Define Tegra30 CAR binding
In-Reply-To: <1356260751-3667-5-git-send-email-pgaikwad@nvidia.com>
References: <1356260751-3667-1-git-send-email-pgaikwad@nvidia.com>
 <1356260751-3667-5-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130109154200.GA29605@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 23, 2012 at 12:05:44PM +0100, Prashant Gaikwad wrote:
> The device tree binding models Tegra30 CAR (Clock And Reset)
> as a single monolithic clock provider.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>

...

> +  81	i2cslow

...

> +  217	i2cslow

I guess 81 is the correct number?

Cheers,

Peter.
