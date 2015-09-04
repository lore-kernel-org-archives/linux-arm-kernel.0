From: kuleshovmail@gmail.com (Alexander Kuleshov)
Date: Fri, 4 Sep 2015 18:19:22 +0600
Subject: [PATCH 1/3] arm64/cpufeature.h: Add macros for a cpu features
 testing
In-Reply-To: <55E987CA.4090302@arm.com>
References: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
 <55E987CA.4090302@arm.com>
Message-ID: <CANCZXo4rtkVr-m3p1kyavS6Ruu7Gbwp-qqR9BhEtiZ39+NahvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-04 18:00 GMT+06:00 Suzuki K. Poulose <Suzuki.Poulose@arm.com>:
> There is generic CPUID feature helper queued for 4.3, which can extract
> the feature bits
>
>  cpuid_feature_extract_field(feature, shift)
>
> You might want to use it instead. Btw, I have a patch series(waiting for
> the merge window, before I post), which changes the way we initialise the
> HWCAP bits.

Hello,

Thanks for feedback first of all. So, I'll wait while your changes will be
in the mainline kernel and will reconsider the changes.

Thank you.
