From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 6 Oct 2017 18:37:15 +0100
Subject: [PATCH v2 26/28] arm64/sve: Add documentation
In-Reply-To: <59D7A4AF.40408@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-27-git-send-email-Dave.Martin@arm.com>
 <59D7A4AF.40408@arm.com>
Message-ID: <20171006173715.GC3611@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 06, 2017 at 04:43:43PM +0100, Szabolcs Nagy wrote:
> On 31/08/17 18:00, Dave Martin wrote:
> > +9.  System runtime configuration
> > +--------------------------------
> > +
> > +* To mitigate the ABI impact of expansion of the signal frame, a policy
> > +  mechanism is provided for administrators, distro maintainers and developers
> > +  to set the default vector length for userspace processes:
> > +
> > +/proc/cpu/sve_default_vector_length
> 
> 
> elsewhere in the patch series i see
> 
> /proc/sys/abi/sve_default_vector_length
> 
> is this supposed to be the same?

Good spot, thanks!

/proc/cpu/ was the old location: they should both say /proc/abi/.
I'll fix it.

---Dave
