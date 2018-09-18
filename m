From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Sep 2018 12:09:39 +0100
Subject: [PATCH v6 0/3] Support Common Not Private translations
In-Reply-To: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
References: <1533042538-26184-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20180918110939.xkuczjjf6upnmgih@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, Jul 31, 2018 at 02:08:55PM +0100, Vladimir Murzin wrote:
> Vladimir Murzin (3):
>   arm64: mm: Support Common Not Private translations
>   arm64: KVM: Enable Common Not Private translations
>   arm64: Introduce command line parameter to disable CNP

I queued the first two patches for 4.20. I've also turned the feature on
by default as is the case with other new architecture features.

Thanks.

-- 
Catalin
