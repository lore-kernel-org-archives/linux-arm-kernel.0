From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 29 Jun 2013 13:11:24 -0700
Subject: [PATCH v5 06/12] memory: mvebu-devbus: Remove address decoding
 window workaround
In-Reply-To: <1372532655-20321-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1372532655-20321-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1372532655-20321-7-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130629201124.GA15981@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 04:04:09PM -0300, Ezequiel Garcia wrote:
> Now that mbus device tree binding has been introduced, remove the address
> decoding window management from this driver.
> A suitable 'ranges' entry should be added to the devbus-compatible node in
> the device tree, as described by the mbus binding documentation.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/memory/mvebu-devbus.c | 64 ++-----------------------------------------
>  1 file changed, 2 insertions(+), 62 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
