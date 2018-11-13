From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 13 Nov 2018 18:55:19 +0200
Subject: [PATCH v6 00/17] Removed nested TPM operations
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA1CD09@hasmsx108.ger.corp.intel.com>
References: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA1CD09@hasmsx108.ger.corp.intel.com>
Message-ID: <20181113165519.GA4752@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 12:30:55PM +0000, Winkler, Tomas wrote:
> > 
> > [was Detach TPM space code out of the tpm_transmit() flow but the scope
> > expanded a bit.]
> 
> I believe you making this series artificially large we can merge the
> first 4 patches and leave the rest for further discussion.

1/17, 2/17 and 3/17 are fairly obvious changes but they still should
have tested-by's. For 4/17 I need a sanity check from James Bottomley
that I'm not forgetting some tidbit of TPM space implementation (has
been while since I've worked on it so better to have 2nd eyes there).

I think also 5/17, 7/17 and 10/17 could be merged.

I can reposition forementioned patches so that they are in the head of
the series.

/Jarkko
