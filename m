From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 18 Feb 2016 08:50:56 -0800
Subject: [PATCH v2] serial: xuartps: Enable OF earlycon support
In-Reply-To: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
References: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
Message-ID: <56C5F670.50005@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2016 11:57 PM, Michal Simek wrote:
> Support early console setup via DT for all listed compatible strings.
> Remove EARLYCON_DECLARE which was done by:
> "Use common framework for earlycon declarations"
> (sha1: 2eaa790989e03900298ad24f77f1086dbbc1aebd)
> when OF_EARLYCON_DECLARE is defined.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
