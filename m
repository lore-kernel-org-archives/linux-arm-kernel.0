From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 8 Mar 2013 23:30:42 +0530
Subject: [PATCH] ARM: DT: tegra20/tegra30: Correct clock id for UARTB
In-Reply-To: <513A2433.2080002@wwwdotorg.org>
References: <1362751245-32432-1-git-send-email-ldewangan@nvidia.com>
 <513A2433.2080002@wwwdotorg.org>
Message-ID: <513A274A.4030709@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013 11:17 PM, Stephen Warren wrote:
> On 03/08/2013 07:00 AM, Laxman Dewangan wrote:
>> UARTB clock bit in CAR register is 7. Correcting this
>> in DTS file.
> The register bit is 7, but the clock ID in the Tegra CAR DT binding is
> 96 for UART2 or 97 for VFIR. This was due to there being 1 clock bit and
> 2 separate IP block reset bits, or the other way around, so we highlight
> the issue by assigning different clock IDs. See the comment before the
> list of clock IDs in the binding document.

Aaha, I missed the Documentation part. I was looking for DT entry only 
found this.
