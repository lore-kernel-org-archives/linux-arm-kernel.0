From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 15 Jan 2011 19:39:51 +0300
Subject: [patch 1/2] Fix pwm-related build failure
In-Reply-To: <20110113113006.269152863@rtp-net.org>
References: <20110113112638.328269873@rtp-net.org>
	<20110113113006.269152863@rtp-net.org>
Message-ID: <4D31CDD7.5050105@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-01-2011 14:26, Arnaud Patard (Rtp) wrote:

> Commit 076762aa52de48688f6e1b6999fe58d736479f37 is adding a macro whis is

    Please also specify the commit summary in parens.

> calling imx_add_mxc_pwm() but gives it 2 parameters while it's taking only
> one parameters.

WBR, Sergei
