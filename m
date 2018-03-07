From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 15:30:28 +0100
Subject: [PATCH 2/2] arm64: dts: replace 'linux,
 stdout-path' with 'stdout-path'
In-Reply-To: <20180228224116.2596-2-robh@kernel.org>
References: <20180228224116.2596-1-robh@kernel.org>
 <20180228224116.2596-2-robh@kernel.org>
Message-ID: <CAK8P3a3j+VE8eRPXx--m_y46f45PbKVH1B51VGmpkXmnjONRdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 11:41 PM, Rob Herring <robh@kernel.org> wrote:
> 'linux,stdout-path' has been deprecated for some time in favor of
> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
> Search and replace the one occurrence with 'stdout-path'.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to next/dt as well, thanks!

     Arnd
