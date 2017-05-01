From: jcm@jonmasters.org (Jon Masters)
Date: Mon, 1 May 2017 00:53:32 -0400
Subject: [PATCH 0/2] arm64: Workaround for Thunder KVM hang issues.
In-Reply-To: <20170424184250.667-1-david.daney@cavium.com>
References: <20170424184250.667-1-david.daney@cavium.com>
Message-ID: <1863d70c-eb50-1368-2a51-56110be0f352@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2017 02:42 PM, David Daney wrote:
> We have discovered in rare circumstances, guest execution may result
> in host not receiving one or more interrupts.  This does not otherwise
> affect guest or host execution and/or isolation.

Thanks David. I have tested these and can confirm that a 4.11 machine
previously experiencing an issue has stable VMs with these.

Tested-by: Jon Masters <jcm@redhat.com>
