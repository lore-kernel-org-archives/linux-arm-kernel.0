From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 10 Aug 2012 10:51:11 -0600
Subject: [PATCH V3] ARM: dt: tegra: ventana: add regulators
In-Reply-To: <1344017356-29352-1-git-send-email-swarren@wwwdotorg.org>
References: <1344017356-29352-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50253BFF.8070606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 12:09 PM, Stephen Warren wrote:
> Ventana uses a TPS6586x regulator. Instantiate this, and hook up a
> couple of fixed GPIO-controlled regulators too.

Applied to for-3.7/dt.
