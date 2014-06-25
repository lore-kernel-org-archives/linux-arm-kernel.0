From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jun 2014 14:33:55 -0600
Subject: [PATCH] ARM: tegra: Migrate Apalis T30 PCIe power supply scheme
In-Reply-To: <67868f9464baee36eba48582d56f586ad69d3e86.1403725976.git.marcel@ziswiler.com>
References: <67868f9464baee36eba48582d56f586ad69d3e86.1403725976.git.marcel@ziswiler.com>
Message-ID: <53AB3233.1080208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 02:10 PM, Marcel Ziswiler wrote:
> This migration is required for continued PCIe operation after commit:
> 
> d3c7e24b84fcb62f96fa9a585a41f1829f326878

Thanks. I've applied this to Tegra's for-3.17/dt branch, where this file
was added. I also shortened the commit hash and added the commit subject
in the description, so it's more human-readable.
