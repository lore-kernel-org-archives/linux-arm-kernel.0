From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 12:14:22 -0600
Subject: [PATCH 1/3] ARM: dts: Create a cros-ec-keyboard fragment
In-Reply-To: <1401920421-25729-1-git-send-email-dianders@chromium.org>
References: <1401920421-25729-1-git-send-email-dianders@chromium.org>
Message-ID: <539F33FE.8040501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 04:20 PM, Doug Anderson wrote:
> All ChromeOS ARM devices that have the standard "CrOS EC" have the
> same keyboard mapping.  It's silly to include this same definition
> everywhere.  Let's create a "dtsi" fragment that we can include from
> many different boards.
> 
> This fragment is based on what's currently in tegra124-venice2.dts

I've applied this series to Tegra's for-3.17/dt-cros-ec-kbd branch. I'll
send a pull request to arm-soc shortly.
