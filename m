From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 20:22:58 -0600
Subject: [PATCH 1/2] ARM: dts: da850-lego-ev3: Add node for reboot modes
In-Reply-To: <1515723685-19286-2-git-send-email-david@lechnology.com>
References: <1515723685-19286-1-git-send-email-david@lechnology.com>
 <1515723685-19286-2-git-send-email-david@lechnology.com>
Message-ID: <203bb1f1-e4d4-ca2f-4b66-386f29873861@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 08:21 PM, David Lechner wrote:
> This adds a new node for reboot modes on LEGO MINDSTORMS EV3. The EV3's
> bootloader looks for a magic number in the ARM local RAM and if found,
> it will boot into a special firmware update mode where the flash memory
> can be written via USB.
> 
> This has been testing working using the command:
> 
>      # systemctl reboot loader
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Doh. I forgot to rebase, so this won't apply cleanly. V2 coming right up.
