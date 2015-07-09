From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 9 Jul 2015 12:02:56 +0200
Subject: [PATCH] KVM: Add Kconfig option to signal cross-endian guests
In-Reply-To: <1436428145-29823-1-git-send-email-thuth@redhat.com>
References: <20150707195012-mutt-send-email-mst@redhat.com>
 <1436428145-29823-1-git-send-email-thuth@redhat.com>
Message-ID: <20150709100256.GG13530@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 09:49:05AM +0200, Thomas Huth wrote:
> The option for supporting cross-endianness legacy guests in
> the vhost and tun code should only be available on systems
> that support cross-endian guests.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
