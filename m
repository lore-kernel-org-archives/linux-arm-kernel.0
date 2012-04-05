From: arjan@linux.intel.com (Arjan van de Ven)
Date: Thu, 05 Apr 2012 06:37:13 -0700
Subject: [RFC PATCH] cpuidle: allow per cpu latencies
In-Reply-To: <1333619620-21201-1-git-send-email-pdeschrijver@nvidia.com>
References: <1333619620-21201-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <4F7DA009.4010802@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2012 2:53 AM, Peter De Schrijver wrote:
> This patch doesn't update all cpuidle device registrations. I will do that

question is if you want to do per cpu latencies, or if you want to have
both types of C state in one big table, and have each of the tegra cpyu
types pick half of them...
