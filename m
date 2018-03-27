From: david@lechnology.com (David Lechner)
Date: Tue, 27 Mar 2018 11:48:47 -0500
Subject: [PATCH v3 0/8] ARM: davinci: complete the conversion to using the
 reset framework
In-Reply-To: <20180327092031.11251-1-brgl@bgdev.pl>
References: <20180327092031.11251-1-brgl@bgdev.pl>
Message-ID: <6166e140-b417-dd22-10cf-843db3958226@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wasn't there a v4 already? Is this really v5 instead of v3?


On 03/27/2018 04:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series converts the only user of the handcoded, mach-specific reset
> routines in the davinci platform to using the reset framework.
> 
> Patches 1-3 add necessary lookups/DT-properties.

Should I just squash the DT changes into my common-clock-v9 branch
since those patches haven't been picked up yet anyway? That will be
2 fewer patches to keep track of.
