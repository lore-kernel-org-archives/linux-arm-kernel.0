From: npiggin@gmail.com (Nicholas Piggin)
Date: Fri, 1 Dec 2017 10:36:21 +1000
Subject: [PATCH 5/7] arm64: keep .altinstructions and .altinstr_replacement
In-Reply-To: <CAKwvOdn9TEO3G9+7DsQ+mR-nf=50Moydfvft=h_RketDZ2iODA@mail.gmail.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-6-samitolvanen@google.com>
 <CAKwvOd=PcTVZaMCtY7Wy-OEi7Dd1M4hVz8mpJCQR3M+dVROdmg@mail.gmail.com>
 <20171130115827.709f1818@roar.ozlabs.ibm.com>
 <CAKwvOdn9TEO3G9+7DsQ+mR-nf=50Moydfvft=h_RketDZ2iODA@mail.gmail.com>
Message-ID: <20171201103621.366e797d@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Nov 2017 09:00:35 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Wed, Nov 29, 2017 at 5:58 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > (Comparing `readelf -S` before/after is a way to spot bugs.)  
> 
> Do you have a script that can be used to diff 2 `readelf -S`, look for
> missing references, and report an error? Might be easier to rerun that
> every so often and see what's missing.

I don't, I was just doing it by hand.

Thanks,
Nick
