From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 18 Feb 2015 15:25:51 +0000
Subject: [PATCH v2 3/3] xen/arm: allow console=hvc0 to be omitted for
 guests
In-Reply-To: <1424267513-15836-4-git-send-email-julien.grall@linaro.org>
References: <1424267513-15836-1-git-send-email-julien.grall@linaro.org>
 <1424267513-15836-4-git-send-email-julien.grall@linaro.org>
Message-ID: <1424273151.20761.18.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-18 at 13:51 +0000, Julien Grall wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> This patch registers hvc0 as the preferred console if no console
> has been specified explicitly on the kernel command line.
> 
> The purpose is to allow platform agnostic kernels and boot images
> (such as distro installers) to boot in a Xen/ARM domU without the
> need to modify the command line by hand.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Julien Grall <julien.grall@linaro.org>

Acked-by: Ian Campbell <ian.campbell@citrix.com>
