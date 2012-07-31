From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 31 Jul 2012 20:46:46 +0400
Subject: [PATCH 3/6] ARM: ux500: Fix merge error,
 so such struct 'snd_soc_u8500'
In-Reply-To: <1343741493-17671-6-git-send-email-lee.jones@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-6-git-send-email-lee.jones@linaro.org>
Message-ID: <50180BF6.6080908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/31/2012 05:31 PM, Lee Jones wrote:

  Subject doesn't parse for me...

> The platform attempts to register platform device 'snd_soc_u8500'
> which doesn't actually exist. Here we change the reference to the
> correct one 'snd_soc_mop500'.

> Signed-off-by: Lee Jones <lee.jones@linaro.org>

WBR, Sergei
