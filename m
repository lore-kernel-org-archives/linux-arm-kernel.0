From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 15:29:58 +0100
Subject: [PATCH 1/2] arm: dts: replace 'linux,
 stdout-path' with 'stdout-path'
In-Reply-To: <20180228224116.2596-1-robh@kernel.org>
References: <20180228224116.2596-1-robh@kernel.org>
Message-ID: <CAK8P3a028i+1vRNjA+=ra69wqjFKi4vEtj4rgUoHdB7Nage98A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 11:41 PM, Rob Herring <robh@kernel.org> wrote:
> 'linux,stdout-path' has been deprecated for some time in favor of
> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
> Search and replace all the of occurrences with 'stdout-path'.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied now, thanks a lot for the continued cleanup. I see we already
have the respective dtc update in linux-next, so hopefully we get the
warnings down again now.

     Arnd
