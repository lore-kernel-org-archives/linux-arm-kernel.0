From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Fri, 06 Oct 2017 16:43:43 +0100
Subject: [PATCH v2 26/28] arm64/sve: Add documentation
In-Reply-To: <1504198860-12951-27-git-send-email-Dave.Martin@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-27-git-send-email-Dave.Martin@arm.com>
Message-ID: <59D7A4AF.40408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/17 18:00, Dave Martin wrote:
> +9.  System runtime configuration
> +--------------------------------
> +
> +* To mitigate the ABI impact of expansion of the signal frame, a policy
> +  mechanism is provided for administrators, distro maintainers and developers
> +  to set the default vector length for userspace processes:
> +
> +/proc/cpu/sve_default_vector_length


elsewhere in the patch series i see

/proc/sys/abi/sve_default_vector_length

is this supposed to be the same?
