From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Mon, 23 Oct 2017 06:34:53 +0000
Subject: [PATCH 00/15] networking drivers refcount_t conversions
In-Reply-To: <20171022.023132.2040144937883625039.davem@davemloft.net>
References: <1508484229-19706-1-git-send-email-elena.reshetova@intel.com>
 <20171022.023132.2040144937883625039.davem@davemloft.net>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B802B41C4@IRSMSX102.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Elena Reshetova <elena.reshetova@intel.com>
> Date: Fri, 20 Oct 2017 10:23:34 +0300
> 
> > Note: these are the last patches related to networking that perform
> > conversion of refcounters from atomic_t to refcount_t.
> > In contrast to the core network refcounter conversions that
> > were merged earlier, these are much more straightforward ones.
> >
> > This series, for various networking drivers, replaces atomic_t reference
> > counters with the new refcount_t type and API (see include/linux/refcount.h).
> > By doing this we prevent intentional or accidental
> > underflows or overflows that can led to use-after-free vulnerabilities.
> >
> > The patches are fully independent and can be cherry-picked separately.
> > Patches are based on top of net-next.
> > If there are no objections to the patches, please merge them via respective trees
> 
> I've applied this entire series to net-next.  If there are any fixups or
> follow-ups please send them as relative patches.
> 
> Thank you.

Thank you very much David! Will send fixups separately.

Best Regards,
Elena.
