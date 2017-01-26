From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 26 Jan 2017 15:51:00 -0800
Subject: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
In-Reply-To: <1485473846-24537-2-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-2-git-send-email-kraxel@redhat.com>
Message-ID: <30bf98f0-c893-d306-ab79-3ba741790919@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2017 03:37 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Few things with your submission:

- if you send more than one patch, a cover letter is a welcome to
explain your changes

- try to provide commit messages for things that are not obvious (in
fact, most maintainers actually request commit messages even for trivial
things)

- have not we switched to the iproc SDHCI driver, or is this for the
other SDIO connected peripherals here?

Thanks
-- 
Florian
