From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 10 Apr 2012 13:31:54 +0300
Subject: [RFC PATCH] cpuidle: allow per cpu latencies
In-Reply-To: <4F7DA009.4010802@linux.intel.com>
References: <1333619620-21201-1-git-send-email-pdeschrijver@nvidia.com>
 <4F7DA009.4010802@linux.intel.com>
Message-ID: <20120410103154.GB22721@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 03:37:13PM +0200, Arjan van de Ven wrote:
> On 4/5/2012 2:53 AM, Peter De Schrijver wrote:
> > This patch doesn't update all cpuidle device registrations. I will do that
> 
> question is if you want to do per cpu latencies, or if you want to have
> both types of C state in one big table, and have each of the tegra cpyu
> types pick half of them...
> 

How would the governor then know which C states belong to which CPUs?

Cheers,

Peter.
