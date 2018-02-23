From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Feb 2018 10:57:00 -0800
Subject: [PATCH 3/3] memory: brcmstb: dpfe: support new way of passing
 data from the DCPU
In-Reply-To: <1518554440-21805-4-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
 <1518554440-21805-4-git-send-email-mmayer@broadcom.com>
Message-ID: <20180223185700.16821-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Feb 2018 12:40:40 -0800, Markus Mayer <mmayer@broadcom.com> wrote:
> The DCPU can now send message data in two ways:
>   - via the data RAM, as before (this is now message type 0)
>   - via the message RAM (this is message type 1)
> 
> In order to support both methods, we check the message type of the
> response (bits 31:28) and then treat the offset (bits 27:0)
> accordingly.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/fixes, thanks!
--
Florian
